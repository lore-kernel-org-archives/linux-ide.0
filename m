From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [parisc-linux] Re: a fix for NS87415 on C3K broken
Date: Wed, 22 Sep 2004 18:41:20 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040922174120.GO16153@parcelfarce.linux.theplanet.co.uk>
References: <20040922163708.GD4766@colo.lackof.org> <41501936000007AF@mail-7-bnl.tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:427 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266009AbUIVRlV
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 22 Sep 2004 13:41:21 -0400
Content-Disposition: inline
In-Reply-To: <41501936000007AF@mail-7-bnl.tiscali.it>
List-Id: linux-ide@vger.kernel.org
To: Joel Soete <soete.joel@tiscali.be>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>, parisc-linux@parisc-linux.org

On Wed, Sep 22, 2004 at 07:21:08PM +0200, Joel Soete wrote:
> > Moving the DECLARE_PCI_FIXUP_HEADER() around is probably the clue
> > I needed to resolve this.
> >
> I am curious to find an expalnation too.

Yep, that's it.  That moves it to be the first entry on the list, and
it handles the suckyio IDE cotroller before the quirk_ide_bases does.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
