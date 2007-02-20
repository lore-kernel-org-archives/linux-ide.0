From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 5/5] ahci: consider SDB FIS containing spurious NCQ completions
 HSM violation
Date: Tue, 20 Feb 2007 10:46:58 -0500
Message-ID: <45DB17F2.5000707@garzik.org>
References: <11704009511903-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43965 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965160AbXBTPrB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Feb 2007 10:47:01 -0500
In-Reply-To: <11704009511903-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> SDB FIS containing spurious NCQ completions is a clear protocol
> violation.  Currently, only some Maxtors with early firmware revisions
> are showing this problem.  Those firmwares have other NCQ related
> problems including buggy NCQ error reporting and occasional lock up
> after NCQ errors.
> 
> Consider spurious NCQ completions HSM violation and freeze the port
> after it.  EH will turn off NCQ after this happens several times.
> Eventually drives which show this behavior should be blacklisted for
> NCQ.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/ahci.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)

ACK, but patch does not apply to current #upstream


