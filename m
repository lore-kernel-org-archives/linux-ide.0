From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 2/4] irq-pio: remove ap->dataout_task
Date: Tue, 04 Oct 2005 06:09:23 -0400
Message-ID: <434254D3.1050904@pobox.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412BCF.4080408@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:422 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751206AbVJDKJc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 06:09:32 -0400
In-Reply-To: <43412BCF.4080408@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Mark Lord <mlord@pobox.com>, Brett Russ <russb@emc.com>

Albert Lee wrote:
> @@ -3018,7 +3017,8 @@ fsm_start:
>  	qc_completed = 0;
>  
>  	switch (ap->hsm_task_state) {
> -	case HSM_ST_IDLE:
> +	case HSM_ST_FIRST:
> +		ata_pio_first_block(ap);
>  		return;
>  
>  	case HSM_ST:

Am I missing something?  You're removing the handling of HSM_ST_IDLE, 
which looks very wrong.

AFAICS, even after your patch is applied, the completion of a qc still 
transitions the state to HSM_ST_IDLE.  Perhaps your patch is missing 
some transitions -from- HSM_ST_IDLE to HSM_ST_FIRST?

	Jeff


