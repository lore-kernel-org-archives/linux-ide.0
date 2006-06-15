From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Thu, 15 Jun 2006 12:41:56 +0900
Message-ID: <4490D704.9040907@gmail.com>
References: <11501274293403-git-send-email-htejun@gmail.com>	 <1150271814.7132.55.camel@forrest26.sh.intel.com>	 <44900F41.8020602@gmail.com> <1150335221.7132.71.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:53465 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932431AbWFODmD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 23:42:03 -0400
Received: by wr-out-0506.google.com with SMTP id 70so257745wra
        for <linux-ide@vger.kernel.org>; Wed, 14 Jun 2006 20:42:02 -0700 (PDT)
In-Reply-To: <1150335221.7132.71.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> Yeah, on memsleep host_set->dev->power.power_state is set to
> PM_EVENT_SUSPEND in ata_host_set_suspend(). Then during resume process,
> firstly ata_host_set_resume() is called, in which host_set->dev->power.
> power_state is set to PMSG_ON, then ata_eh_handle_resume() is called
> later. This is the reason why ap->host_set->dev->power.power_state.event
> is 0 in ata_eh_handle_resume(). This is a race condition.

Yeap, you're right.  Hmmm.. weird.  I haven't noticed that race 
condition during my tests.  I think we can use a DFLAG to mark that a 
device had been spun down.  Thanks for spotting it.

-- 
tejun
