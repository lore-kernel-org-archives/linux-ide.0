From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: libata TODO: ioread/iowrite work (was Re: [PATCH libata:upstream] remove compiler warnings)
Date: Mon, 22 Aug 2005 22:39:05 +0200
Message-ID: <20050822203905.GA17753@mars.ravnborg.org>
References: <20050822091129.GA15373@htj.dyndns.org> <430A2C91.4060803@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751109AbVHVUiZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <430A2C91.4060803@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

> - install Linus's "sparse" source checker
> - run 'make C=1' in the kernel tree, and make sure libata and drivers 
> don't spew warnings
make C=2 will check all files. Handy so you do not need to do a make
clean.
make C=2 drivers/scsi/libata.ko to limit it to libata.

	Sam
