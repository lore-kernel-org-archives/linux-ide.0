From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] re-fix sata_sil quirk (w/ description)
Date: Tue, 22 Jun 2004 22:11:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40D8E6E3.6090006@pobox.com>
References: <Pine.GSO.4.33.0406222107080.25702-200000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266058AbUFWCMD
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Jun 2004 22:12:03 -0400
In-Reply-To: <Pine.GSO.4.33.0406222107080.25702-200000@sweetums.bluetronic.net>
List-Id: linux-ide@vger.kernel.org
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>

Ricky Beam wrote:
> On Tue, 22 Jun 2004, Jeff Garzik wrote:
> 
>> The patch itself is unchanged, but I have checked it in with a detailed
>> technical description, including my rationale.
> 
> ...
> 
> #   ... This means that the affected SATA drives will see
> #   decreased performance, but set of affected drives is small and will
> #   never grow larger.
> 
> Actually, the set of affected drives is about 1/3rd of the SATA drive
> market: all current model Seagate drives. (Maxtor and WD being the other
> thirds.)  My money says their new 400G monster will have the exact same
> problems.
> 
> I'm using ST3160023AS drives (3 FW 3.18, 1 FW 3.05.) I'd include their
> manufacture date, but they're rather busy right now so I cannot pull them
> out.

Seagate claims they fixed the problem, so I doubt it...

	Jeff



