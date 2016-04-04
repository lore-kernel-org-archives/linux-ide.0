From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/3] ata: ahci-platform: Add ports-implemented DT
 bindings.
Date: Mon, 4 Apr 2016 00:15:56 -0500
Message-ID: <20160404051556.GH17806@rob-hp-laptop>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459497178-31090-3-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1459497178-31090-3-git-send-email-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, jmaggard10@gmail.com, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

On Fri, Apr 01, 2016 at 08:52:57AM +0100, Srinivas Kandagatla wrote:
> On some SOCs PORTS_IMPL register value is never programmed by the
> firmware and left at zero value. Which means that no sata ports are
> available for software. AHCI driver used to cope up with this by
> fabricating the port_map if the PORTS_IMPL register is read zero,
> but recent patch broke this workaround as zero value was valid for
> NVMe disks.
> 
> This patch adds ports-implemented DT bindings as workaround for this issue
> in a way that DT can can override the PORTS_IMPL register in cases where
> the firmware did not program it already.
> 
> Fixes: 566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3)
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 ++++
>  drivers/ata/ahci_platform.c                             | 3 +++
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
