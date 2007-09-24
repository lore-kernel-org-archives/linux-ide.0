From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [patch 1/2] Enable link power management for ata drivers
Date: Mon, 24 Sep 2007 16:28:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709241624460.24423@alien.or.mcafeemobile.com>
References: <20070924215140.966161778@intel.com>
 <20070924151320.67f0c332.kristen.c.accardi@intel.com> <46F84460.5090703@tiscali.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758327AbXIXX3P@vger.kernel.org>
In-Reply-To: <46F84460.5090703@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: roel <12o3l@tiscali.nl>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@kernel.dk, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-ide@vger.kernel.org

On Tue, 25 Sep 2007, roel wrote:

> > +	if (!(ap->flags & ATA_FLAG_IPM) || !ata_dev_enabled(dev)) {
> 
> 	if (!((ap->flags & ATA_FLAG_IPM) && ata_dev_enabled(dev))) {

int foo(int i, int j) {
        
        return !(i & 8) || !j;
}

int moo(int i, int j) {
        
        return !((i & 8) && j);
}


gcc -O2 -S:


.globl foo
        .type   foo, @function
foo:
        shrl    $3, %edi
        xorl    $1, %edi
        testl   %esi, %esi
        sete    %al
        orl     %eax, %edi
        andl    $1, %edi
        movl    %edi, %eax
        ret
.globl moo
        .type   moo, @function
moo:
        shrl    $3, %edi
        xorl    $1, %edi
        testl   %esi, %esi
        sete    %al
        orl     %eax, %edi
        andl    $1, %edi
        movl    %edi, %eax
        ret



- Davide
