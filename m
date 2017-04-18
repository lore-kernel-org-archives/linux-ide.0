From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFT] sata: rcar_sata: Reset SATA PHY on resume
Date: Tue, 18 Apr 2017 12:20:20 +0300
Message-ID: <308de569-b3a7-8909-c07c-6d39cab5b287@cogentembedded.com>
References: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms+renesas@verge.net.au>, linux-renesas-soc@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-ide@vger.kernel.org

Hello.

On 4/18/2017 10:02 AM, Simon Horman wrote:

> In the case where power is cut on suspend the SATA PHY state needs to be
> suspended on resume.
>
> This is the case on the Salvator-X board with the r8a7795 or r8a7796 SoC.
> In that environment it has been observed that SATA partitions cannot not be
> accessed on resume.
>
> Based on work by Khiem Nguyen.
>
> Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> * Compile and boot tested only
> ---
>  drivers/ata/sata_rcar.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

    Why the scope prefix in the subject is not just "sata_rcar: "? :-)

[...]

MBR, Sergei
