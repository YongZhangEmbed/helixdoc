import React from 'react';
import { WithStyles, withStyles, TextField, Typography, Grid, Paper, StyleRulesCallback } from '@material-ui/core';
import i18n from '../../service/i18n';
import { observer } from 'mobx-react';
import { Card } from '../../stores/cardStore';
import { CardStore } from '../../stores/cardStore';
import { CardAddStore } from '../../stores/cardAddStore';
import { ISupportGoogleAnalytics, withGoogleAnalytics } from '../../components/WithGoogleAnalytics';
import { IGAField } from './../../service/AnalyticsTracker';

const styles: StyleRulesCallback = theme => ({
	root: {
		display: 'flex',
		flexWrap: 'wrap'
	},
	h5: {
		fontWeight: 500
	},
	paper: {
		paddingTop: theme.spacing.unit * 2,
		paddingBottom: theme.spacing.unit * 2,
		background: '#f7f7f7'
	}
});

interface IProps extends WithStyles<typeof styles> {
	card: Card;
	cardStore: CardStore;
	cardAddStore: CardAddStore;
}

@observer
class CardForm extends React.Component<IProps> implements ISupportGoogleAnalytics {
	private refCVV: React.RefObject<HTMLInputElement>;
	private refCardNumber: React.RefObject<HTMLInputElement>;
	constructor(props) {
		super(props);
		this.handleChange = this.handleChange.bind(this);
		this.handleBlur = this.handleBlur.bind(this);
		this.refCVV = React.createRef();
		this.refCardNumber = React.createRef();
	}

	getFieldsForGA(): IGAField[] {
		return [
			{ name: 'Card Number', hasChanged: this.props.cardAddStore.card.cardNumber.length > 0 },
			{ name: 'CVV', hasChanged: this.props.cardAddStore.card.cvv.length > 0 },
			{ name: 'Nick Name', hasChanged: this.props.cardAddStore.card.nickName.length > 0 }
		];
	}

	handleChange(e) {
		const { cardStore, cardAddStore } = this.props;
		let value = e.target.value;
		const name = e.target.name;
		if (e.target.type === 'checkbox') {
			value = e.target.checked;
		}
		switch (name) {
			case 'cardNumber':
				cardAddStore.card.setCardNumber(value);
				if (cardStore.validateCardNumber(value, cardAddStore.card.cvv)) {
					this.refCardNumber.current!.blur();
					cardStore.validateGenericCard(value, cardAddStore.card.cvv);
				} else {
					cardStore.setIsGenericCard(false);
				}
				break;
			case 'cvv':
				cardAddStore.card.setCVV(value);
				if (cardStore.validateCardNumber(cardAddStore.card.cardNumber, value)) {
					this.refCVV.current!.blur();
					cardStore.validateGenericCard(cardAddStore.card.cardNumber, value);
				} else {
					cardStore.setIsGenericCard(false);
				}
				break;
			case 'nickName':
				cardAddStore.card.setNickName(value);
				break;
			default:
				return;
		}
		cardAddStore.setDisableUpdateBtn(false);
	}
	handleBlur(e) {
		const value = e.target.value;
		this.props.cardAddStore.validateField(e.target.name, value);
	}
	render() {
		const { classes, card } = this.props;
		return (
			<Grid container direction="row" justify="space-between" alignItems="center" spacing={16}>
				<Grid item xs={12}>
					<TextField
						inputRef={this.refCardNumber}
						id="cardNumber"
						margin="normal"
						variant="outlined"
						name="cardNumber"
						error={card.cardNumberErrorMsgKey !== ''}
						fullWidth
						onChange={this.handleChange}
						onBlur={this.handleBlur}
						value={card.cardNumber}
						key={String(
							card.cardNumberErrorMsgKey
								? i18n.t(card.cardNumberErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.cardNumber')
						)}
						label={
							card.cardNumberErrorMsgKey
								? i18n.t(card.cardNumberErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.cardNumber')
						}
						InputLabelProps={{
							shrink: true
						}}
						autoFocus
					/>
				</Grid>
				<Grid item xs={12}>
					<TextField
						inputRef={this.refCVV}
						id="cvv"
						margin="normal"
						variant="outlined"
						name="cvv"
						error={card.cvvErrorMsgKey !== ''}
						fullWidth
						onChange={this.handleChange}
						onBlur={this.handleBlur}
						value={card.cvv}
						key={String(
							card.cvvErrorMsgKey
								? i18n.t(card.cvvErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.CVV')
						)}
						label={
							card.cvvErrorMsgKey
								? i18n.t(card.cvvErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.CVV')
						}
						InputLabelProps={{
							shrink: true
						}}
					/>
				</Grid>
				<Grid item xs={12}>
					<TextField
						id="nickName"
						margin="normal"
						variant="outlined"
						name="nickName"
						error={card.nickNameErrorMsgKey !== ''}
						fullWidth
						onChange={this.handleChange}
						onBlur={this.handleBlur}
						value={card.nickName}
						key={String(
							card.nickNameErrorMsgKey
								? i18n.t(card.nickNameErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.nickName')
						)}
						label={
							card.nickNameErrorMsgKey
								? i18n.t(card.nickNameErrorMsgKey)
								: i18n.t('accountCreationSteps:CardValidationStep.nickName')
						}
						InputLabelProps={{
							shrink: true
						}}
					/>
				</Grid>
			</Grid>
		);
	}
}

export default withStyles(styles)(withGoogleAnalytics<IProps>()(CardForm));
