From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Disk spin down issue on shut down/suspend to disk
Date: Sun, 9 Sep 2007 13:35:02 +0200
Message-ID: <200709091335.03330.rjw@sisk.pl>
References: <838f88840708051428p3d65ff42w627af4bc38f57de3@mail.gmail.com> <200709082329.57811.rjw@sisk.pl> <46E3BAD1.4080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757178AbXIILX2@vger.kernel.org>
In-Reply-To: <46E3BAD1.4080709@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Maciek Rutecki <maciej.rutecki@gmail.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, =?iso-8859-2?q?Micha=B3_sed?= <sedmich@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, htejun@gmail.com, hmh@hmh.eng.br, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Sunday, 9 September 2007 11:20, Maciek Rutecki wrote:
> Rafael J. Wysocki pisze:
> >> Shutdown is completely broken on HP NX6??? laptops.
> > 
> > It's not completely broken, it just handles disks incorrectly and we are not
> > sure whether or not there are any serious consequences of that.  Moreover,
> > it has happened for a long time now, AFAICT, so that's not a regression.
> 
> Maybe it isn't regression, we can call it no matter how, but this issue
> can shorten disk live.

Well, I'll try to carry out some experiments with it later today ...
