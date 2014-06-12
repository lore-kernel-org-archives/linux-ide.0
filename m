From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller driver
Date: Thu, 12 Jun 2014 16:23:06 -0500
Message-ID: <8C69AEA0-877D-4198-BAD4-393695FBC94E@codeaurora.org>
References: <1402600404-19214-1-git-send-email-galak@codeaurora.org> <1402600404-19214-2-git-send-email-galak@codeaurora.org> <539A047B.3010306@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <539A047B.3010306@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Jun 12, 2014, at 2:50 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> On 06/12/14 12:13, Kumar Gala wrote:
>> +static int qcom_ahci_probe(struct platform_device *pdev)
>> +{
>> +	struct ahci_host_priv *hpriv;
>> +	struct clk *rxoob_clk;
>> +	int rc;
>> +
>> +	hpriv =3D ahci_platform_get_resources(pdev);
>> +	if (IS_ERR(hpriv))
>> +		return PTR_ERR(hpriv);
>> +
>> +	/* Try and set the rxoob clk to 100Mhz */
>> +	rxoob_clk =3D of_clk_get_by_name(pdev->dev.of_node, "rxoob");
>=20
> Any reason we can't use devm_clk_get() here?

Was trying to avoid the ref cnt of devm_clk_get() as the clk=92s are ac=
tually handled in ahci_platform_get_resources/ahci_platform_enable_reso=
urces

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
