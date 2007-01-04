From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC,PATCHSET] Managed device resources
Date: Thu, 04 Jan 2007 17:26:43 -0500
Message-ID: <459D7F23.7010807@garzik.org>
References: <1167146313307-git-send-email-htejun@gmail.com> <20070104221916.GI28445@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33683 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965120AbXADW0q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Jan 2007 17:26:46 -0500
In-Reply-To: <20070104221916.GI28445@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Greg KH wrote:
> Hm, but I guess without the follow-up patches for libata, it will not
> really get tested much.  Jeff, if I accept this, what's your feelings of
> letting libata be the "test bed" for it?


It would be easiest for me to merge this through my 
libata-dev.git#upstream tree.  That will auto-propagate it to -mm, and 
ensure that both base and libata bits are sent in one batch.

Just shout if you see NAK-able bits...

Work for you?

	Jeff


