From: maximilian attems <max@stro.at>
Subject: Re: Bug#598518: linux-image-2.6-686: ata_piix module loaded before
	ahci module deactivate hotplug support (regression from lenny)
Date: Tue, 5 Oct 2010 09:05:22 +0000
Message-ID: <20101005090522.GA5947@vostochny.stro.at>
References: <20100929165034.21331.69639.reportbug@albatros.savanenet> <1285799230.28504.105.camel@localhost> <4CAA04FB.7070402@gmail.com> <20101004175438.GZ5947@vostochny.stro.at> <AANLkTikVYpaYd4xOeBeWu9aHieJ+P1nTLJ_eoGyXC2K0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vostochny.stro.at ([78.47.22.85]:49822 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab0JEJFZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 5 Oct 2010 05:05:25 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikVYpaYd4xOeBeWu9aHieJ+P1nTLJ_eoGyXC2K0@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas DEBESSE <thomas.debesse+debian@gmail.com>
Cc: 598518@bugs.debian.org, Ben Hutchings <ben@decadent.org.uk>, linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>

On Tue, Oct 05, 2010 at 09:45:40AM +0200, Thomas DEBESSE wrote:
> 
> So, I'm going to check modules.order and /etc/initramfs-tools/ then I
> will report here what I can see.
> 

please also report which initramfs-tools version you are using,
since lenny there had been ton of fixes:
dpkg -l initramfs-tools

you should be running 0.98.4
