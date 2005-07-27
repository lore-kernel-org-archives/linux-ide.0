From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: ATA Passthru "status return descriptor" additional length field
Date: Wed, 27 Jul 2005 10:13:13 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D060A7C@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:59540 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S261292AbVG0RNM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 13:13:12 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

The libata code sets that field to 14 (the size of the whole status return
descriptor), but the SAT spec (May 17) shows that field set to 12.  Which is
correct?

Regards,
Tim Thelin
