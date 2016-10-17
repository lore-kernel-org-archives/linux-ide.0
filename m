From: Christoph Hellwig <hch@lst.de>
Subject: Re: use pci_alloc_irq_vectors issues
Date: Mon, 17 Oct 2016 11:26:21 +0200
Message-ID: <20161017092621.GA11124@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com> <20161017080103.GA8732@lst.de> <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57856 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932949AbcJQJ0X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 17 Oct 2016 05:26:23 -0400
Content-Disposition: inline
In-Reply-To: <CA+i8gK+dxqJgAcANzsHecE4dD4tGARuaNka-29nZWdrRUL=+Hw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org

Hi Emmanuel,

can you run the lspci -vv command as again, but this time as root
user?  Also just to make sure I interpret your report correctly:
The ata3 devices that's creating the problems is the SK-Hynix device,
probably a SSD that shows up as ahci controller?
