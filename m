From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Possibly wrong BIO usage in ide_multwrite
Date: Mon, 5 Jan 2004 17:47:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200401051747.45039.bzolnier@elka.pw.edu.pl>
References: <1072977507.4170.14.camel@leto.cs.pocnet.net> <200401032302.32914.bzolnier@elka.pw.edu.pl> <20040105040337.GB6393@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040105040337.GB6393@leto.cs.pocnet.net>
Content-Disposition: inline
To: Christophe Saout <christophe@saout.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Monday 05 of January 2004 05:03, Christophe Saout wrote:
> Hi again,
>
> here another experiment.
>
> I have started moving the code over to using the cbio mechanism. I
> have only touched ide-disk.c though, I'm not sure about ide-taskfile.c.

Patch looks nice but I wonder if it is worth doing
(this code should die ASAP).

> The modifications work here with and without multmode and with all kinds
> of bios. Haven't been able to test error conditions since I don't have
> broken hardware. ;-)

Hehe... you can try to break it ;-).

> I also didn't touch ide-taskfile.c which has most probably also been
> broken by the ide_map_buffer change. And I stumbled across the code

Yep.

> calling end_request with a null sector count, ide_end_request will then
> take hard_nr_sectors which will end the whole request even if only one
> bio was finished, huh? Am I missing something here?

No, it is used mainly to fail requests.

This hack should be later removed with care
(there is some strange comment about locking).

> And when is bio == NULL in ide_map_buffer? Where can this happen?

In taskfile code - special requests are not bio baked (taskfile ioctl).

--bart
