From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] ata: sata_rcar: Add r8a7793 device support
Date: Thu, 16 Oct 2014 08:27:10 +0200
Message-ID: <20141016062710.GA19070@verge.net.au>
References: <1413363577-25969-1-git-send-email-ykaneko0929@gmail.com>
 <20141016052054.GF1265@verge.net.au>
 <543F5AE9.7030603@renesas.com>
 <20141016055523.GK1265@verge.net.au>
 <543F6391.4070208@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <543F6391.4070208@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi Khiem-san,

On Thu, Oct 16, 2014 at 03:20:01PM +0900, Khiem Nguyen wrote:
> Hi Simon-san,
> 
> Thanks for your explanation.
> 
> On 10/16/2014 2:55 PM, Simon Horman wrote:
> > Hi Khiem-san,
> > 
> > On Thu, Oct 16, 2014 at 02:43:05PM +0900, Khiem Nguyen wrote:
> >> Hi,
> >>
> >> On 10/16/2014 2:20 PM, Simon Horman wrote:
> >>> On Wed, Oct 15, 2014 at 05:59:37PM +0900, Yoshihiro Kaneko wrote:
> >>>> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >>>>
> >>>> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >>>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >>>
> >>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> >>>
> >>> Tejun, could you consider picking up this change?
> >>
> >> Uhmm, R8A7793 SoC hadn't been supported in upstream Linux kernel yet.
> >> So, is it still OK to take this patch now ?
> > 
> > Yes, I think so. Mainline support for the r8a7793 is in the pipeline
> > and by adding (trivial) driver support before hand the drivers will
> > be able to be used when the SoC code lands.
> 
> Huhm, I think the declaration in device driver should come along with
> the support in SoC DTS file.
> Without it, I doubt how the developer makes sure the validity/correctness
> of the patch.
> (This is what I understood about development for R8A7790 and R8A7791.)

I understand your concern and it is one that I used to hold myself.
However, I believe that this patch has been verified out-of-tree
and its simplicity leads me to believe that it is extremely likely
to work once SoC support hits mainline.

By taking the approach of merging driver changes in this way we
are able to merge driver and SoC code independently which makes
the whole development process rather less constrained and easier to
manage.

> > This is consistent with how other are being handled for the r8a7793.
> If this is our development policy, it's fine. :)

I believe it is.

> >>>> ---
> >>>>
> >>>> This patch is against for-next branch of Tejun's libata repo.
> >>>>
> >>>> v2 [Yoshihiro Kaneko]
> >>>> * Update the binding documentation
> >>>>
> >>>>  Documentation/devicetree/bindings/ata/sata_rcar.txt | 3 ++-
> >>>>  drivers/ata/sata_rcar.c                             | 5 +++++
> >>>>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>>> index 1e61113..74b1130 100644
> >>>> --- a/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>>> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> >>>> @@ -4,7 +4,8 @@ Required properties:
> >>>>  - compatible		: should contain one of the following:
> >>>>  			  - "renesas,sata-r8a7779" for R-Car H1
> >>>>  			  - "renesas,sata-r8a7790" for R-Car H2
> >>>> -			  - "renesas,sata-r8a7791" for R-Car M2
> >>>> +			  - "renesas,sata-r8a7791" for R-Car M2-W
> >>>> +			  - "renesas,sata-r8a7793" for R-Car M2-N
> >>>>  - reg			: address and length of the SATA registers;
> >>>>  - interrupts		: must consist of one interrupt specifier.
> >>>>  
> >>>> diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
> >>>> index 61eb6d7..6f8ed8e 100644
> >>>> --- a/drivers/ata/sata_rcar.c
> >>>> +++ b/drivers/ata/sata_rcar.c
> >>>> @@ -841,6 +841,10 @@ static struct of_device_id sata_rcar_match[] = {
> >>>>  		.compatible = "renesas,sata-r8a7791",
> >>>>  		.data = (void *)RCAR_GEN2_SATA
> >>>>  	},
> >>>> +	{
> >>>> +		.compatible = "renesas,sata-r8a7793",
> >>>> +		.data = (void *)RCAR_GEN2_SATA
> >>>> +	},
> >>>>  	{ },
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(of, sata_rcar_match);
> >>>> @@ -850,6 +854,7 @@ static const struct platform_device_id sata_rcar_id_table[] = {
> >>>>  	{ "sata-r8a7779", RCAR_GEN1_SATA },
> >>>>  	{ "sata-r8a7790", RCAR_GEN2_SATA },
> >>>>  	{ "sata-r8a7791", RCAR_GEN2_SATA },
> >>>> +	{ "sata-r8a7793", RCAR_GEN2_SATA },
> >>>>  	{ },
> >>>>  };
> >>>>  MODULE_DEVICE_TABLE(platform, sata_rcar_id_table);
> >>>> -- 
> >>>> 1.9.1
> >>>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> -- 
> >> Best regards,
> >> KHIEM Nguyen
> >>
> 
> -- 
> Best regards,
> KHIEM Nguyen
> 
