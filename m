From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.51 ide module problem (fwd)
Date: 13 Dec 2002 10:42:46 +0000
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1039776166.25121.15.camel@irongate.swansea.linux.org.uk>
References: <20021213013637.4F2652C0ED@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20021213013637.4F2652C0ED@lists.samba.org>
List-Id: linux-ide@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeff Chua <jchua@fedex.com>, "Adam J. Richter" <adam@yggdrasil.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de, linux-ide@vger.kernel.org, Patrick Mochel <mochel@osdl.org>

On Fri, 2002-12-13 at 01:35, Rusty Russell wrote:
> Also, my stress_modules script gave the following warning then oops
> from ide-cd on 2.5.51 SMP x86 (IDE is built-in):

Yes. This mysteriously stsrted happening. I don't know if its now
trapping a long standing IDE bug or its of the other changes people did
to IDE to make it actually follow the devices model properly. I've got a
slightly similar looking 2.4 bug to chase down which makes me suspect
the former.

