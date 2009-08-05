From: Tauseef Hussain <Tauseef.Hussain@gennum.com>
Subject: RE: Adding new pci vendor id
Date: Wed, 5 Aug 2009 10:24:03 -0400
Message-ID: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF4@EXCHANGE.ad.gennum.com>
References: <E2EFBB65133B9448A32D870B45E3DBB30EEB434CF0@EXCHANGE.ad.gennum.com>,<da824cf30908040955vb26e4b6mbad1f80d5230d282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.gennum.com ([66.207.109.237]:65051 "EHLO mx2.gennum.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934124AbZHEOZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Aug 2009 10:25:29 -0400
In-Reply-To: <da824cf30908040955vb26e4b6mbad1f80d5230d282@mail.gmail.com>
Content-Language: en-AU
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: "jeff@garzik.org" <jeff@garzik.org>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi all
Thanx for your response.
I am using this flavor of linux distribution from red hat
Linux 2.6.29.6-217.2.3.fc11.i686.PAE i686 GNU/Linux
which i obtained on my console on doing a uname -o -s -p -r command.

However i dont have the source code of AHCI driver ahci.c with this distribution.
Can you tell me whom to contact to get the source code for ahci.c for the distribution i am using?


Thanks and regards,
Tauseef
Junior design engineer,
Gennum
________________________________________
From: Grant Grundler [grundler@google.com]
Sent: Tuesday, 4 August 2009 10:25 PM
To: Tauseef Hussain
Cc: Rashmi Mohapatra; linux-ide@vger.kernel.org; Shefali Mishra
Subject: Re: Adding new pci vendor id

On Tue, Aug 4, 2009 at 8:32 AM, Tauseef
Hussain<Tauseef.Hussain@gennum.com> wrote:
> Hi
> I am using a kernel which uses a  precompiled kernel object of ahci.c  viz. ahci.ko
> I would like to know how can i add new pci vendor device id in the ahci_pci_tbl[] structure

See Documentation/SubmittingPatches in your kernel source tree.

If the new HW is intended to work with a distro (e.g., Redhat, SuSe,
Debian, Ubuntu, et al)
you will need to contact each distro and submit a patch in a similar
fashion to them.

> then how can i compile the modified ahci.c and use the .ko file for my use?

The following simplified answer should work for most distro's but
unlikely to work 100% of the time:
    sudo make modules_install
    sudo make install
    sudo reboot

Then interrupt the boot loader (likely grub) to select your kernel.

And given the nature of your questions, I suggest you visit
kttp://kernelnewbies.org .

cheers,
grant

This communication contains confidential information intended only for the addressee(s). If you have received this communication in error, please notify us immediately and delete this communication from your mail box.
