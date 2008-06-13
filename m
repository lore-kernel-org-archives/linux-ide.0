From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/5] libata: consistently use msecs for time durations
Date: Fri, 13 Jun 2008 02:55:50 -0400
Message-ID: <485219F6.9040105@garzik.org>
References: <12112174741373-git-send-email-htejun@gmail.com> <12112174751988-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58949 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761256AbYFMGzy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jun 2008 02:55:54 -0400
In-Reply-To: <12112174751988-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> libata has been using mix of jiffies and msecs for time druations.
> This is getting confusing.  As writing sub HZ values in jiffies is
> PITA and msecs_to_jiffies() can't be used as initializer, unify unit
> for all time durations to msecs.  So, durations are in msecs and
> deadlines are in jiffies.  ata_deadline() is added to compute deadline
> from a start time and duration in msecs.
> 
> While at it, drop now superflous _msec suffix from arguments and
> rename @timeout to @deadline if it represents a fixed point in time
> rather than duration.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-core.c |   44 +++++++++++++++++++++-----------------------
>  drivers/ata/libata-eh.c   |   33 +++++++++++++++++----------------
>  drivers/ata/libata-pmp.c  |    3 ++-
>  drivers/ata/libata-sff.c  |   15 ++++++++-------
>  drivers/ata/pata_bf54x.c  |    6 +++---
>  drivers/ata/pata_scc.c    |    2 +-
>  include/linux/libata.h    |   26 ++++++++++++++++----------
>  7 files changed, 68 insertions(+), 61 deletions(-)

applied 2-5


