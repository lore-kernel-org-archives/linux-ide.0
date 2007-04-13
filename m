From: "Raz Ben-Jehuda(caro)" <raziebe@gmail.com>
Subject: promise ncq
Date: Fri, 13 Apr 2007 23:43:03 +0300
Message-ID: <5d96567b0704131343ld23f2b6v8d2e3b13fcdfff19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:6042 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932189AbXDMUnE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 16:43:04 -0400
Received: by nz-out-0506.google.com with SMTP id s1so841247nze
        for <linux-ide@vger.kernel.org>; Fri, 13 Apr 2007 13:43:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>

Jeff hello
I have a promise cotroller that exports its disks as logical volumes
to the OS, and the OS sees them as physical drives . kernel is 2.6.17.
I have set  a disk manualy to support ncq using a command line tool
provided by promise.
I have "echo 1 > /sys/block/..../dev/rescan" and the ncq bit did not
show in dmesg.
queue_depth is set to 32 no matter if ncq is enabled or not. I cannot echo
to queue_depth , I get "permision denied" error ( libata faq says i
can do that ).

How can I tell if the OS knows of this change ?

thank you

-- 
Raz
