From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: AHCI w/ATAPI device problems on Intel Tolapai
Date: Thu, 1 May 2008 14:50:01 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0702A0D2F6@orsmsx420.amr.corp.intel.com>
References: <39B20DF628532344BC7A2692CB6AEE070294E5FA@orsmsx420.amr.corp.intel.com> <480FFAD9.5040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43944 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751006AbYEAVuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 May 2008 17:50:52 -0400
Content-class: urn:content-classes:message
In-Reply-To: <480FFAD9.5040606@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

>Hmm.. these look like media presence polling commands from 
>haldaemon.  I 
>have no idea why it's failing on ahci tho.  All polling failures I've 
>seen till now was device dependent, not controller.  You can disable 
>media presence polling using hal-disable-polling /dev/sr0.  If you 
>disabling polling, does the device work correctly?  ie. can 
>you read and 
>record using it?
>
>-- 
>tejun
>

How do I get the hal-disable-polling utility?  I get a command not
found.

Thanks,

Jason
