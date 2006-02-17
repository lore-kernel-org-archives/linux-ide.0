From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: Fix IDE locking error.
Date: Fri, 17 Feb 2006 15:53:04 +0100
Message-ID: <58cb370e0602170653g30bd36f3j4b1a0e95f64ecbeb@mail.gmail.com>
References: <20060216223916.GA8463@redhat.com>
	 <58cb370e0602170057x59b23957n3e858d5ac4918326@mail.gmail.com>
	 <1140186532.4283.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.198]:56309 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964920AbWBQOxH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Feb 2006 09:53:07 -0500
Received: by nproxy.gmail.com with SMTP id a4so285126nfc
        for <linux-ide@vger.kernel.org>; Fri, 17 Feb 2006 06:53:05 -0800 (PST)
In-Reply-To: <1140186532.4283.2.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On 2/17/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Gwe, 2006-02-17 at 09:57 +0100, Bartlomiej Zolnierkiewicz wrote:
> > Could we get a decent description of the problem and of the patch?
>
> Audit the lock state on all entries to the tune function and it
> certainly was the case that the old IDE layer could call it with the
> lock either already held or not.

Thank you but this is not a patch description, this is a recipe
for me to spend nice friday's evening staring all over IDE code
and making patch description myself...

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt ?

Bartlomiej
