From: Jim Ramsay <jim.ramsay@gmail.com>
Subject: Re: ata_scsi_queuecmd locking question
Date: Wed, 17 Aug 2005 09:23:13 -0600
Message-ID: <4789af9e050817082353db4520@mail.gmail.com>
References: <4789af9e05081615216c1de2be@mail.gmail.com>
	 <43026A34.5000403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.204]:30743 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751153AbVHQPXQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Aug 2005 11:23:16 -0400
Received: by zproxy.gmail.com with SMTP id r28so142492nza
        for <linux-ide@vger.kernel.org>; Wed, 17 Aug 2005 08:23:13 -0700 (PDT)
In-Reply-To: <43026A34.5000403@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>

On 8/16/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jim Ramsay wrote:
> > I'm just looking into libata-scsi.c, and noticed that the comments for
> > ata_scs_queuecmd note that it is supposed to obtain host_set->lock.
> > It doesn't seem to do so.
> >
> > Should it?
> 
> The SCSI layer acquires this lock for us.

Ah yes, now I see - This lock is also pointed at by the host->host_lock

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
