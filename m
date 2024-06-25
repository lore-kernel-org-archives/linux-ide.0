Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C1494AF
	for <linux-ide@vger.kernel.org>; Tue, 25 Jun 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719307995; cv=none; b=kfM7lCKghk7Bgkb44QEEThxIkM5apAckH6zARCorblYoMVxlIvXONNTV1qQMJQR/5LpZFZcqRFov9kRvKwfC7Q6q5/PMcixYc8WOceX1CoxC9NOSLjyVZS7TrqbMVackn454VlYDZZ3eR+Exs/Au9ETsPkie3X+aOWxLjwne3nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719307995; c=relaxed/simple;
	bh=n8KVQbpt7wHt4BqMx3bK8g7wwv96NgbTd99atM42L8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGPsNSpZtZH+fPjzgakOPk5b8V6qmL9WBNp9DLz8b+KtKZyShYG1GS883WaO7Ad/fuibDCpW5l1Umg77Mqn+SilpB3NDlPgbVJOz+weJ90Hkn3iICUn/FhMmoPttGDWOgUhbLo7q6e/lnXXENde2GDjzhIg+Rg/okn+Ted7/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYhUkRTj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYhUkRTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD5DC32781;
	Tue, 25 Jun 2024 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719307994;
	bh=n8KVQbpt7wHt4BqMx3bK8g7wwv96NgbTd99atM42L8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYhUkRTjmFBBgS8Vo4OMCQLyA1LrpFdNEtoP+jUYE9vS5uzK2YehyWbZFFdAD9oKB
	 DSdKXIy0+zWYPK7lGotm7eTItceoV9BTIDF2pmvpy0UsBbCn5ckyxm5wAzp+2PmACK
	 9UOg/r7LDjotjg6EqzRcVM4X/E4N3+bw2evcEpiOxZSqm0/CiAAein5lBDch3KHb6b
	 awzhMo3aMMCLlgkOpIt26QC4WZ46tWC0lYqMlmATb2cuLd4VBBeDQferj/yrp8Mpgd
	 xc4dH6APAN+O1PEdCSBWl2gQqYoVfvYa89j60MmzN6XkIa/65YFQjTSeDudhN8zD9p
	 LWOIUwwgTgASw==
Date: Tue, 25 Jun 2024 11:33:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Alessandro Maggio <alex.tkd.alex@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial
 BX SSD1 models
Message-ID: <ZnqO1kRB0qUa6Nmo@ryzen.lan>
References: <20240624132729.3001688-2-cassel@kernel.org>
 <82e310a4-5668-4edf-b3a8-2c7898a7c4cb@kernel.org>
 <CAOHHr1_3rigY3vM03uVkfpvbmNbvcPbxYyKBdktXkKsQBnS_8Q@mail.gmail.com>
 <ZnqBkyxPp5IPARvl@x1-carbon.wireless.wdc>
 <CAOHHr1-Yg5cGOm_45oybMja8c+6g50YMEQURP8JD+ww1=VgqJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOHHr1-Yg5cGOm_45oybMja8c+6g50YMEQURP8JD+ww1=VgqJw@mail.gmail.com>

On Tue, Jun 25, 2024 at 10:54:38AM +0200, Alessandro Maggio wrote:
> Nope sorry, I don't know how to build and/or how to apply the patch. If you
> have a tutorial to share will be awesome

Sure!

You will need some packages installed in order to build the kernel,
so start off by installing the packages listed here:
https://docs.kernel.org/admin-guide/quickly-build-trimmed-linux.html#install-build-requirements


### then these are the steps:
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
$ cd linux
$ git checkout v6.10-rc5
$ cp /boot/config-$(uname -r) .config
$ make olddefconfig

### if using distro with dnf
$ sudo dnf install b4
### if using distro with apt
$ sudo apt install b4

### apply the patch from the mailing list:
$ b4 shazam https://lore.kernel.org/linux-ide/20240624132729.3001688-2-cassel@kernel.org/

### do a git show to verify that the patch has been applied correctly:
$ git show -v

$ make -j$(nproc)
$ sudo make modules_install
$ sudo make install

### if your distro is using grubby, you can check if the kernel will boot the
### newly installed kernel by default:
$ sudo grubby --default-kernel

### it should show something like:
/boot/vmlinuz-6.10-rc5+

### reboot
$ sudo reboot

### if your distro is not using grubby, make sure to select the
### newly built kernel version in the grub menu at boot

### verify that you have booted the newly built kernel version:
$ cat /proc/version

### it should show something like:
Linux version 6.10-rc5+ (nks) (gcc (GCC) 14.1.1 20240607 (Red Hat 14.1.1-5), GNU ld version 2.41-37.fc40) #1 SMP PREEMPT_DYNAMIC Wed Jun 24 13:37:00 UTC 2024


Kind regards,
Niklas
