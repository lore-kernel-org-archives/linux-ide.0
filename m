From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Mon, 04 Oct 2004 17:05:05 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4161BB01.5080607@pobox.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com> <20041004155647.A9589@florence.linkmargin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268527AbUJDVFR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 17:05:17 -0400
In-Reply-To: <20041004155647.A9589@florence.linkmargin.com>
List-Id: linux-ide@vger.kernel.org
To: Andy Warner <andyw@pobox.com>
Cc: linux-ide@vger.kernel.org

Andy Warner wrote:
> Jeff Garzik wrote:
> 
>>[...]
>>That's because libata doesn't call the proper hot-unplug hooks.  Call 
>>those hooks, and the problem goes away.
> 
> 
> Suggested reading, anyone ?


Documentation/scsi/scsi_mid_low_api.txt for 2.6.x.  "good luck" for 
2.4.x, and libata needs to work on 2.4.x as well (at least for the time 
being)

	Jeff


