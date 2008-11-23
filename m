From: Peter Favrholdt <linux-ide@how.dk>
Subject: Re: [PATCH #upstream-fixes] sata_promise: request follow-up SRST
Date: Sun, 23 Nov 2008 23:38:31 +0100
Message-ID: <4929DB67.1090702@how.dk>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org>	<18719.65298.689618.835202@harpo.it.uu.se>	<492059B1.4030708@how.dk>	<49205AD7.3080009@how.dk>	<4920D093.2030508@kernel.org>	<492159E0.1050804@how.dk>	<4922165E.9070203@kernel.org>	<49230361.2010001@how.dk>	<492371F4.7020400@kernel.org>	<49253A6D.1040202@how.dk> <18725.17831.755158.999770@harpo.it.uu.se> <49263F80.2060607@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:37157 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbYKWWic (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Nov 2008 17:38:32 -0500
In-Reply-To: <49263F80.2060607@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Hi Tejun and list,

This mail just to say I'm alive and testing the patch but so far no 
errors (on my hardware).

Tejun Heo wrote:
> sata_promise hardreset doesn't seem to be able to acquire the initial
> D2H Reg FIS after hardreset leading to hardreset timeouts.  Request
> follow-up SRST.
> 
>  http://article.gmane.org/gmane.linux.ide/36186
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
> Peter, can you please test this one too?  It's essentially the same
> code just slightly prettier.  Mikael, what do you think about this?

I'm still testing the new patch (on 2.6.27.7), but so far I haven't had 
any failures - it seems my hardware has started to behave well - very 
unfortunate ;-)

I'll keep on testing - hopefully I'll see some of the usual errors soon 
  - and the new patch recovers alright.

Best regards,

I'm still testing the new patch (on 2.6.27.7), but so far I haven't had 
any failures - it seems my hardware has started to behave well - very 
unfortunate ;-)

 > Jeff, please commit only after Peter's verification and Mikael's ACK.

I'll keep on testing - hopefully I'll see some of the usual errors soon 
  - and the new patch will recover alright. I'll keep you updated.

Best regards,

Peter

>  drivers/ata/sata_promise.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
> index ba9a257..917038a 100644
> --- a/drivers/ata/sata_promise.c
> +++ b/drivers/ata/sata_promise.c
> @@ -710,7 +710,12 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
>  			      unsigned long deadline)
>  {
>  	pdc_reset_port(link->ap);
> -	return sata_sff_hardreset(link, class, deadline);
> +
> +	/* sata_promise can't reliably acquire the first D2H Reg FIS
> +	 * after hardreset.  Do non-waiting hardreset and request
> +	 * follow-up SRST.
> +	 */
> +	return sata_std_hardreset(link, class, deadline);
>  }
>  
>  static void pdc_error_handler(struct ata_port *ap)
