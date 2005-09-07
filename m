From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 0/4] ide: Break ide_lock to per-hwgroup lock
Date: Wed, 07 Sep 2005 20:06:14 +0100
Message-ID: <1126119974.8928.33.camel@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
	 <1126112950.8928.18.camel@localhost.localdomain>
	 <20050907181654.GB3769@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932210AbVIGSle@vger.kernel.org>
In-Reply-To: <20050907181654.GB3769@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>, Alok Kataria <alokk@calsoftinc.com>
List-Id: linux-ide@vger.kernel.org

On Mer, 2005-09-07 at 11:16 -0700, Ravikiran G Thirumalai wrote:
> I tested it on a 2way box with a piix controller. It got through Bonnie++.  
> I have access to piix controllers only, so that was the only controller 
> I changed.  I did not read the errata though... :(

Errata matter a lot unfortunately - older IDE controllers commonly have
bugs where changing the set up of one interface affects the other even
if a transfer is occuring.

> Do you think the approach is unsafe, even if the piix tune routine is
> serialized with a per-driver lock?  Bartlomiej?

If the documents/errata for the chips are checked then I can see it
making sense. I do worry that it may introduce other races because the
IDE locking is such a mess but that would be true of any change and
eventually has to be addressed.

I think it makes sense, with corrections.
