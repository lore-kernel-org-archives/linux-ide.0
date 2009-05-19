From: Albert Astals Cid <albert@miraveo.com>
Subject: Re: sata_via oops on copying files?
Date: Tue, 19 May 2009 22:35:56 +0200
Message-ID: <200905192235.56916.albert@miraveo.com>
References: <20090519091655.c0bed8b1fc13fcbc567bd8d4c339afd4.8d107e4704.wbe@email.secureserver.net> <20090519211052.55d01236@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from enginyeriainformatica.cat.224.160.195.in-addr.arpa ([195.160.224.245]:36112
	"EHLO enterprise.coeic.org" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753006AbZESUpg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 May 2009 16:45:36 -0400
In-Reply-To: <20090519211052.55d01236@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

A Dimarts, 19 de maig de 2009, Alan Cox va escriure:
> On Tue, 19 May 2009 09:16:55 -0700
>
> "Albert Astals Cid" <albert@miraveo.com> wrote:
> > Please CC me, i'm not in the list.
> >
> > Not sure if this or bugzilla is preferred, so doing both, shout me if i
> > should wait on bugzilla.
>
> None of this looks IDE related - the first looks like an IRQ routing
> problem which is usually but not always a buggy BIOS. The random crashes
> look like faulty hardware but its always hard to tell hardware and
> software bugs.
>
> Does the system pass memtest86 for 24 hours ?

Hi Alan, 

If i don't use the Compact Flash attached to the miniPCI->IDE->CF adapter it 
works like a charm, it's only when i start writting (reading seems to work 
fine) from the CF card that the kernel oopses, that's why i thought it might 
be IDE/sata_via related.

Is it possible to work around IRQ problems? If so I guess this is not the 
correct mailing list for that question anymore, so can you suggest a better 
one? And if it's not possible i guess all i have left is bugging my hardware 
manufacturer.

Thanks,
  Albert
