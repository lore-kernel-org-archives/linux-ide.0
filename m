From: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 13:33:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031030133316.6bd00b4a.akpm@osdl.org>
References: <200310301601.55588.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200310301601.55588.schlicht@uni-mannheim.de>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
>
>  today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The config.gz 
>  is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda' newly started 
>  processes die due to a received SIGSEGV. No bad kernel messages appear...

Probably we need to turn off TCQ in kernel config until the confidence
level is higher.

>  Disabling TCQ again doesn't help, only e reboot does...

That will be because you have incorrect program text in pagecache, left
over from when the driver was in TCQ mode.
