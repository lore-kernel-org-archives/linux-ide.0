From: Christoph Hellwig <hch@lst.de>
Subject: Re: use pci_alloc_irq_vectors issues
Date: Mon, 17 Oct 2016 10:01:03 +0200
Message-ID: <20161017080103.GA8732@lst.de>
References: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+i8gKJ1BnOE8tOzxfbFJcG1qa9XchiDBQSGZUHUOch6byi+tQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Emmanuel Benisty <benisty.e@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

[added linux-ide and linux-pci to the CC list]

Hi Emmanuel,


> The following commit prevents my machine to boot properly:
> 
>     0b9e2988a ahci: use pci_alloc_irq_vectors
> 
> Crappy quality smartphone pic here: http://i.imgur.com/X1QETFi.jpg
> 
> Reverting this commit solves the issue.
> 
> Please let me know should you need any further info.

Can you send me the output ofthe following commands from a working
boot:

cat /proc/interrupts
lspci -vv
dmesg

Thanks a lot for the report
