From: Andy Warner <andyw@pobox.com>
Subject: Re: libata & scsi rescan.
Date: Mon, 4 Oct 2004 15:56:47 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041004155647.A9589@florence.linkmargin.com>
References: <20041001123951.A23006@florence.linkmargin.com> <415DA2C0.3060600@pobox.com> <20041001141244.B23006@florence.linkmargin.com> <415DB03E.5090005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:26811 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267619AbUJDU6e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 4 Oct 2004 16:58:34 -0400
Content-Disposition: inline
In-Reply-To: <415DB03E.5090005@pobox.com>; from jgarzik@pobox.com on Fri, Oct 01, 2004 at 03:30:06PM -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [...]
> That's because libata doesn't call the proper hot-unplug hooks.  Call 
> those hooks, and the problem goes away.

Suggested reading, anyone ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
