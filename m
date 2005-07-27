From: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: ATA Passthru "status return descriptor" additional length field
Date: Wed, 27 Jul 2005 13:26:03 -0400
Message-ID: <20050727172601.GC22686@tuxdriver.com>
References: <CA45571DE57E1C45BF3552118BA92C9D060A7C@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ra.tuxdriver.com ([24.172.12.4]:42244 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262109AbVG0R02 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 13:26:28 -0400
Content-Disposition: inline
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D060A7C@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: linux-ide@vger.kernel.org

On Wed, Jul 27, 2005 at 10:13:13AM -0700, Timothy Thelin wrote:

> The libata code sets that field to 14 (the size of the whole status return
> descriptor), but the SAT spec (May 17) shows that field set to 12.  Which is
> correct?

I'm sure the spec is correct...gotta patch? :-)

John
-- 
John W. Linville
linville@tuxdriver.com
