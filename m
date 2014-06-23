From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH] phy: qcom: Add driver for QCOM APQ8064 SATA PHY
Date: Mon, 23 Jun 2014 13:12:58 -0500
Message-ID: <C77397FA-1247-4D99-A0AC-9EFE45F7036E@codeaurora.org>
References: <1403546409-10860-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1403546409-10860-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-ide@vger.kernel.org, Sujit Reddy Thumma <sthumma@codeaurora.org>
List-Id: linux-ide@vger.kernel.org


On Jun 23, 2014, at 1:00 PM, Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:

> Add a PHY driver for uses with AHCI based SATA controller driver on the
> APQ8064 family of SoCs.
> 
> This patch is a forward port plus separating PHY code of SATA driver
> from Qualcomm's v3.4 andriod kernel.
> 
> Tested on IFC6410 board.
> 
> CC: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> drivers/phy/Kconfig                 |   7 +
> drivers/phy/Makefile                |   1 +
> drivers/phy/phy-qcom-apq8064-sata.c | 358 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 366 insertions(+)
> create mode 100644 drivers/phy/phy-qcom-apq8064-sata.c

Did you look at the 3.10 Android kernel tree version of the phy driver?

Also do you have a DT binding spec to go with this?

- k