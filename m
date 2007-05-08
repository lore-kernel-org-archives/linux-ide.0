From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] sata_via: add missing PM hooks
Date: Tue, 08 May 2007 12:27:05 +0200
Message-ID: <46405079.6070300@gmail.com>
References: <463B357A.4090703@gmail.com> <e34e42440705080254v2fdd5069yccb946f71dec5231@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:44407 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934701AbXEHK1Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 06:27:16 -0400
Received: by nz-out-0506.google.com with SMTP id o1so1911513nzf
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 03:27:15 -0700 (PDT)
In-Reply-To: <e34e42440705080254v2fdd5069yccb946f71dec5231@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeroen Janssen <jeroen.janssen@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

Jeroen Janssen wrote:
> Hi,
> 
> Any idea how I can track that this has been picked up/applied (I
> looked at some of the git repositories on kernel.org, but as far as I
> can tell, this patch is not in yet).

It's still pending.  What usually happens is Jeff replying with the body
saying 'applied' and the patch gets into libata-dev#upstream or
#upstream-fixes and then merged into Linus's tree.  For stable release,
after Jeff acks it, Greg or any other stable team member picks it up and
writes a formatted mail about it to everyone on the S-O-B: or Cc: list
and stable mailing list.  So, nope, it hasn't happend yet but you'll get
a notice when it happens.

-- 
tejun
