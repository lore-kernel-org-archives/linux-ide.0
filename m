From: Mark Lord <mlord@pobox.com>
Subject: Re: libata total system lockup fix
Date: Thu, 11 Aug 2005 22:22:39 -0400
Message-ID: <42FC07EF.9060506@pobox.com>
References: <42E4ED70.1050501@pobox.com> <42E4FC75.70006@pobox.com> <42E50AE9.3000207@rtr.ca> <42F2E267.50402@gmail.com> <20050805040105.GA18466@htj.dyndns.org> <42FBB14E.5040002@pobox.com> <42FBF22D.5090009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:34063 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S964798AbVHLCWc
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 22:22:32 -0400
In-Reply-To: <42FBF22D.5090009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <liml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, hare@suse.de

Tejun Heo wrote:
> 
>  * _All_ errors are handled in EH thread.
>  * Once any error has occurred, all normal processing stops until error 
> condition is cleared by EH.

Do you mean "all normal processing" for that channel stops,
or *ALL* processing on all libata channels stops?

Obviously the former, I presume.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com

