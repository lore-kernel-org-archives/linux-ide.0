From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Thu, 07 Oct 2004 18:25:39 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4165C263.4080102@pobox.com>
References: <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com> <4161BB01.5080607@pobox.com> <20041006173656.A18221@florence.linkmargin.com> <416496CC.4090105@pobox.com> <20041006214746.A18793@florence.linkmargin.com> <4164B548.7030700@pobox.com> <4164BDD6.6000404@pobox.com> <20041007171457.B21662@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269854AbUJGW0A
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Oct 2004 18:26:00 -0400
In-Reply-To: <20041007171457.B21662@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org, Doug Ledford <dledford@redhat.com>

Andy Warner wrote:
> 		sdev = scsi_add_device(ap->host, 0, 0, 0) ;

> 		sdev = scsi_device_lookup(ap->host, 0, 0, 0);

These args are wrong.  Consider master/slave configurations.

Also, remember my short message about a debounce timer.  It's not as 
simple as this... you need to make sure the driver doesn't "scream" 
add_device/remove_device while the SATA bus settles.

	Jeff


