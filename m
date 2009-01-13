From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata_sff_hsm_move warning
Date: Tue, 13 Jan 2009 13:57:00 +0000
Message-ID: <20090113135700.4f2fac4e@lxorguk.ukuu.org.uk>
References: <20090113142707.70c311ec@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44258 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756672AbZAMN4t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Jan 2009 08:56:49 -0500
In-Reply-To: <20090113142707.70c311ec@hyperion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On Tue, 13 Jan 2009 14:27:07 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Jeff, all,
> 
> FYI, I'm seeing this warning at boot time with kernel 2.6.29-rc1-git1
> on x86_64:

Yes - the WARN_ON in question is broken and this now shows up - just
delete the WARN_ON.
