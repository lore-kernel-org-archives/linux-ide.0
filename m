From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 16:17:49 -0400
Message-ID: <429A236D.8030307@pobox.com>
References: <20050526140058.GR1419@suse.de> <429793C8.8090007@gmail.com> <42979C4F.8020007@pobox.com> <42979FA3.1010106@gmail.com> <20050528121258.GA17869@suse.de> <4299BD23.6010004@gmail.com> <20050529190259.GA29770@suse.de> <429A2238.8010604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261430AbVE2USA@vger.kernel.org>
In-Reply-To: <429A2238.8010604@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Thonke <iogl64nx@gmail.com>
Cc: Jens Axboe <axboe@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Michael Thonke wrote:
> Well the subjective feeling is great through! What I noticed is a
> improvement on rsync (goes slighty faster drive to drive).
> The noise decrease now it only make noise on very heavy IO reads and writes.


It might be as simple as...  NCQ means the drive is doing more work. 
More work means more noise.

	Jeff
