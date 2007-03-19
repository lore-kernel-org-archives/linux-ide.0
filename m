From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata: CD and dvd devices not recognized
Date: Mon, 19 Mar 2007 16:29:53 +0800
Message-ID: <45FE4A01.2050903@tw.ibm.com>
References: <45F873AC.6010204@gmail.com> <200703181610.33714.bzolnier@gmail.com> <45FD5927.7080104@gmail.com> <200703181654.00829.bzolnier@gmail.com> <45FE0417.8040200@tw.ibm.com> <45FE483C.9050207@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:59971 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbXCSIaD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Mar 2007 04:30:03 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2J8U2pe024663
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 04:30:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l2J8U2NQ054180
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 02:30:02 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l2J8U1TU022316
	for <linux-ide@vger.kernel.org>; Mon, 19 Mar 2007 02:30:02 -0600
In-Reply-To: <45FE483C.9050207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: YUP <yupadmin@gmail.com>
Cc: albertl@mail.com, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

YUP wrote:
> What about ata_piix, have I enable this?
> 

It's ok to use either IDE (piix) or libata (ata_piix) to drive the HP drive.
We don't need the log of the HP drive since it seems to work ok.

--
albert


