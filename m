From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH 0/3] Enable ahci_st for stih407 and fix hang
Date: Tue, 3 Mar 2015 13:23:09 +0100
Message-ID: <54F5A7AD.9000906@st.com>
References: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425300519-13747-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, tj@kernel.org
Cc: lee.jones@linaro.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Peter,

On 03/02/2015 01:48 PM, Peter Griffin wrote:
> Hi,
>
> Now that miphy28lp phy is present upstream we can add sata DT nodes for
> stih407 family silicon. As part of testing this I found a hang
> with the current driver implmentation which does some register writes
> before enabling the IP clock. Presumably on stih416 devices the sata
> clock must have already been enabled by the targetpack/bootloader.
>
> This series also tidys up some inaccuracies in the DT documentation
> where the doc hasn't kept aligned with the driver. In addtion to these
> fixes I've also added an example for stih407 silicon.
>
> Peter Griffin (3):
>    ahci: st: Update the ahci_st DT documentation
>    ARM: DT: STi: STiH407: Add sata DT nodes.
>    ahci: st: st_configure_oob must be called after IP is clocked.
>
>   Documentation/devicetree/bindings/ata/ahci-st.txt | 45 ++++++++++++++++-------
>   arch/arm/boot/dts/stih407-family.dtsi             | 44 ++++++++++++++++++++++
>   drivers/ata/ahci_st.c                             |  6 ++-
>   3 files changed, 80 insertions(+), 15 deletions(-)
>

For the series, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
