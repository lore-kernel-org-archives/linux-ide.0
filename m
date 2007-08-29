From: Dave Jones <davej@redhat.com>
Subject: Re: HSM violation spew.
Date: Wed, 29 Aug 2007 16:09:15 -0400
Message-ID: <20070829200915.GJ31948@redhat.com>
References: <20070829184925.GF31948@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372AbXH2UJS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Aug 2007 16:09:18 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l7TK9Hxh019844
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 16:09:17 -0400
Received: from gelk.kernelslacker.org (vpn-248-3.boston.redhat.com [10.13.248.3])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7TK9GIa025486
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 16:09:16 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id l7TK9F1s022389
	for <linux-ide@vger.kernel.org>; Wed, 29 Aug 2007 16:09:15 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id l7TK9FJD022388
	for linux-ide@vger.kernel.org; Wed, 29 Aug 2007 16:09:15 -0400
Content-Disposition: inline
In-Reply-To: <20070829184925.GF31948@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, Aug 29, 2007 at 02:49:25PM -0400, Dave Jones wrote:
 > Just noticed this in dmesg..
 > 
 > ata3.00: exception Emask 0x2 SAct 0x1fffd SErr 0x0 action 0x2 frozen
 > ata3.00: spurious completions during NCQ issue=0x0 SAct=0x1fffd FIS=004040a1:00040000

There's a bunch of these that have been reported in Fedora bugzilla too..

https://bugzilla.redhat.com/show_bug.cgi?id=245512
https://bugzilla.redhat.com/show_bug.cgi?id=249045

	Dave

-- 
http://www.codemonkey.org.uk
