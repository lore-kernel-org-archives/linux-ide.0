From: George Georgalis <george@galis.org>
Subject: Re: SIIMAGE sata fails with 2.6.7
Date: Wed, 23 Jun 2004 10:16:59 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040623141659.GD30929__27260.224594693$1088003582@trot.local>
References: <20040622170557.GA16617@trot.local> <40D895C6.3070306@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:11655 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S266553AbUFWPMr
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2004 11:12:47 -0400
Content-Disposition: inline
In-Reply-To: <40D895C6.3070306@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org

On Tue, Jun 22, 2004 at 04:25:42PM -0400, Jeff Garzik wrote:
>does sata_sil driver work for you?

I have this file,

-rw-r--r--    1 500      500         12779 Jun 16 01:18 ./drivers/scsi/sata_sil.c

but I don't see a switch for it in the config, also I'm not sure where
the most recent patch for it is.

// George


-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631

