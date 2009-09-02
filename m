From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: convert to ->proc_fops
Date: Tue, 01 Sep 2009 17:53:05 -0700 (PDT)
Message-ID: <20090901.175305.175212369.davem@davemloft.net>
References: <20090831222713.GA9834@x200.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:36002
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755472AbZIBAwu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Sep 2009 20:52:50 -0400
In-Reply-To: <20090831222713.GA9834@x200.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: adobriyan@gmail.com
Cc: linux-ide@vger.kernel.org

From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 1 Sep 2009 02:27:13 +0400

> ->read_proc, ->write_proc are going away, ->proc_fops should be used instead.
> 
> The only tricky place is IDENTIFY handling: if for some reason
> taskfile_lib_get_identify() fails, buffer _is_ changed and at least
> first byte is overwritten. Emulate old behaviour with returning
> that first byte to userspace and reporting length=1 despite overall -E.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

Applied, thanks.
