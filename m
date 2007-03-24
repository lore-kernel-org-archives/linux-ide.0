From: Thomas Meyer <thomas@m3y3r.de>
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Sat, 24 Mar 2007 18:04:59 +0100
Message-ID: <46055A3B.6050107@m3y3r.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <20070323185022.GQ752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932314AbXCXRD5@vger.kernel.org>
In-Reply-To: <20070323185022.GQ752@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-pci@atrey.karlin.mff.cuni.cz, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk schrieb:
> Subject    : second suspend to disk in a row results in an oops  (libata?)
> References : http://lkml.org/lkml/2007/3/17/43
> Submitter  : Thomas Meyer <thomas@m3y3r.de>
> Status     : unknown
>   

The problem is identified: http://lkml.org/lkml/2007/3/22/150
