From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v3 2/3] ata: Add Qualcomm ARM SoC AHCI SATA host controller driver
Date: Thu, 21 Aug 2014 13:46:24 -0500
Message-ID: <6726054A-9CF9-4A5C-A98E-4D44A5782076@codeaurora.org>
References: <1403030217-21554-1-git-send-email-galak@codeaurora.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1403030217-21554-1-git-send-email-galak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-ide@vger.kernel.org


On Jun 17, 2014, at 1:36 PM, Kumar Gala <galak@codeaurora.org> wrote:

> Add support for the Qualcomm AHCI SATA controller that exists on seve=
ral
> SoC and specifically the IPQ806x family of chips.  The IPQ806x SATA s=
upport
> requires the associated IPQ806x SATA PHY Driver to be enabled as well=
=2E
>=20
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
> v3:
> * Added comment about suspend/resume not supported
> * Fixup ahci_platform_init_host for upstream change to interface
> * cleanup error handling of rxoob clk, moved to devm_clk_get/put
>=20
> v2:
> * Fixed MODULE_LICENSE to be GPL v2
>=20
> drivers/ata/Kconfig     | 10 ++++++
> drivers/ata/Makefile    |  1 +
> drivers/ata/ahci_qcom.c | 90 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> 3 files changed, 101 insertions(+)
> create mode 100644 drivers/ata/ahci_qcom.c

Any other comments on these patches?

I=92ll send an update that builds against top of tree.

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
