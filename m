From: "Rus V. Brushkoff" <brushkoff@gmail.com>
Subject: Re: AMD SP5100 SATA low perfomance
Date: Fri, 27 Jul 2012 12:22:14 +0300
Message-ID: <CAKu2wpQe+SR3BSsrf+oNzfok6OdQtBKMeYfTGdNOcc-s-AWjjQ@mail.gmail.com>
References: <CAKu2wpS-9T+jeab4HoBozuxa-7LPVCL3+3JZok-QkTHs6CNksA@mail.gmail.com>
 <20120724204454.GC5167@liondog.tnic> <CAKu2wpTFZNY4nwi47gRPbzaHUFPRfJEZa+GTgO4L=vJ-y+9gCA@mail.gmail.com>
 <20120726100440.GB30717@aftab.osrc.amd.com> <CAKu2wpSw-jTMnRkZyDf9aGuNqY7kRp6AUUHKr7CVoo_QXRzj=Q@mail.gmail.com>
 <CAKu2wpQY3=VK-7RZjheRjaYPN2OQxoD=r1qU08DwmjM9xhkxcQ@mail.gmail.com>
 <20120726180854.GD9161@aftab.osrc.amd.com> <CAKu2wpThVHc9nAL=xvcPSKcv-cnOFp+Y41CpQyxsqo292FzjRA@mail.gmail.com>
 <CAKu2wpRkHnAdwiwuoyXfS+KrWQ7DBed1yh_K5eSu0o2d0GWJuA@mail.gmail.com> <20120727090719.GA13992@aftab.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:44938 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751565Ab2G0JW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jul 2012 05:22:56 -0400
Received: by lahd3 with SMTP id d3so2009586lah.19
        for <linux-ide@vger.kernel.org>; Fri, 27 Jul 2012 02:22:54 -0700 (PDT)
In-Reply-To: <20120727090719.GA13992@aftab.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>
Cc: linux-ide@vger.kernel.org

> "Sh*t" really only begins to describe this. So let me get this
> correctly: your Hitachi hdds weren't mounted in a very stable manner to
> the mobo chassis and vibrations from the fan caused them to fail writes
> and retry a _lot_ leading to the write performance drop?

The HDD's _was_ mounted very tight and stable, so the FAN vibration is
propagated to HDD without the problems, next the internal
accelerometer founds this vibration and lowers all the HDD operations
! If I get out the HDD from the case and mechanically isolate it from
the FAN vibration the speed momentally grows to the max value !

> And the WD ones don't have a problem with the vibrations?

The desktop WD do not have this issue as it has much more mass than
mobile one. As you can see by tests made by me - the mobile WD behaves
nearly same as Hitachi one - it lowers the HDD operations by -20Mb/s
value.

> Wow! Looks like some idiot was saving on production material/design to
> make the drives cheaper. Talk about a major serious FAIL.

This idiot is me ;) I do not take this issue in account.

Rus

-- 
Rus
