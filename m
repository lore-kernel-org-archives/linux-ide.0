From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: shelved ioctl-get-identity patch
Date: Mon, 06 Jun 2005 12:24:30 -0400
Message-ID: <42A478BE.1010907@pobox.com>
References: <42A12E80.8090203@pobox.com> <42A472AC.8040307@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261494AbVFFQYj@vger.kernel.org>
In-Reply-To: <42A472AC.8040307@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Mark Lord wrote:
> For now, "hdparm -I" works just fine using HDIO_DRIVE_CMD,
> but if somebody could show me how to use ATA PASSTHRU,
> then I'll port it over to that.

Use the SG_IO ioctl to send ATA passthru CDBs.  Passthru CDBs are 
defined in the T10 "SAT" specification.

blktool should have example code ;-)

	Jeff
