From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH 2/3] ARM: DT: STi: STiH407: Add sata DT nodes.
Date: Thu, 30 Apr 2015 13:06:27 +0200
Message-ID: <55420CB3.8040800@st.com>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org> <1427787309-1601-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427787309-1601-3-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, tj@kernel.org, srinivas.kandagatla@gmail.com
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org



On 03/31/2015 09:35 AM, Peter Griffin wrote:
> Now that the miphy28lp is upstream, we can add the sata dt nodes
> for stih407 family silicon. This has been tested on b2120 board
> J4 (sata0 channel). These nodes are disabled by default as a
> special mini pci-e to sata daughter board is required which
> isn't shipped with the board.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 44 +++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
>
Applied in sti-dt-for-v4.2.

Thanks!
Maxime
