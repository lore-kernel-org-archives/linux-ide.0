From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Western Digital GreenPower drives and Linux
Date: Sat, 12 Apr 2008 19:11:15 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0804121903200.8405@fbirervta.pbzchgretzou.qr>
References: <200804092118.35501.tvrtko@ursulin.net>  <200804100848.08442.tvrtko@ursulin.net>  <1207831481.1514.8.camel@localhost> <bb145bd20804100801y157b4a34m82f084d27f1e0586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755633AbYDLRLZ@vger.kernel.org>
In-Reply-To: <bb145bd20804100801y157b4a34m82f084d27f1e0586@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Pernegger <pernegger@gmail.com>
Cc: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


On Thursday 2008-04-10 17:01, Christian Pernegger wrote:
>
>>  Those fancy new WD GreenPower drives seem to be heavily suffering from the
>>  rapidly increasing head load/unload problem. [...] I got one of them
>>  (WD5000AACS) recently and to my horror [...]
>
>>  [...] With it the unload feature can be either disabled or timer set from
>>  100ms to 25.5 seconds. But obviously I can't try it...
>
>Why? Using a DOS boot disk once would not be that bad as a workaround,
>would it?

This DOS nonsense does not work anywhere outside x86.
I see people put *lots* of afterthought in their utilities, hardware even.

WD is not the first to do this unload nonsense, I've noticed it with 
Toshiba before: http://lkml.org/lkml/2006/11/15/413 Since then, I am 
dependent on the thkd[1] module and no hdparm is going to fix it; the 
module does a dumb read every now and then on one device, causing 
streaming performance to kink periodically, but it works at least at 
keeping the disk alive. (Reason it's in kernel: better to have even when 
userspace is not running.) Improvements welcome.



[1] ftp://ftp5.gwdg.de/pub/linux/misc/suser-jengelh/rawkernel/
somewhere in there since recently.
