From: Thomas Drillich <th@drillich.com>
Subject: Re: ide dvd burner detected as ide-tape
Date: Mon, 13 Oct 2008 00:18:50 +0200
Message-ID: <200810130018.52888.th@drillich.com>
References: <200810010100.06299.th@drillich.com> <200810092013.50945.bzolnier@gmail.com> <20081009183925.GA24460@psychosis.jim.sh>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <20081009183925.GA24460@psychosis.jim.sh>
Content-Disposition: inline
Sender: linux-hotplug-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jim Paris <jim@jtan.com>, linux-hotplug@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Am Donnerstag, 9. Oktober 2008 schrieb Jim Paris:
> Bartlomiej Zolnierkiewicz wrote:
> > Thanks.  Does the following patch help?
> >
> > From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > Subject: [PATCH] ide: quirk for LG GH22LP20 DVD burner
> >
> > LG GH22LP20 DVD burner ("HL)DP-ST@V@-RAI CH22HP20") with firmware 1.00
> > reports 0x01 ("Sequential-access device") as the peripheral device type
> > instead of 0x05 ("CD-ROM device").
>
> That looks more like a hardware problem with a flakey bit.
> For example GH22LP20 with bit 2 always cleared = CH22HP20.
> DVD-ROM with bit 2 sometimes cleared = @V@-RAI.
> And the peripheral device type also has bit 2 cleared.

yup your patch seems to work .. thx bart

but it won't work really nice .. I try to get a replacement drive


-- 
mit freundlichem Gruss -- regards

Thomas Drillich
