From: Dan van der Ster <dan@vanderster.com>
Subject: ata_dev_acpi_handle - NULL ptr deref (bug #48211)
Date: Wed, 3 Oct 2012 13:30:56 +0200
Message-ID: <CABZ+qqkQY4jRpTjLcOmLwBHY7Q8o1ooiqT82-Y6ogZp5OL6=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40502 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab2JCLbh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Oct 2012 07:31:37 -0400
Received: by oagh16 with SMTP id h16so7252389oag.19
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2012 04:31:37 -0700 (PDT)
Received: by oagh16 with SMTP id h16so7252378oag.19
        for <linux-ide@vger.kernel.org>; Wed, 03 Oct 2012 04:31:36 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: mjg@redhat.com

Hi,
I filed this bug report:
   https://bugzilla.kernel.org/show_bug.cgi?id=48211
and Alan suggested I mail this list.

I cannot boot 3.6 with acpi on using this hardware:
    Shuttle sp35p2, Intel P35, AHCI SATA
    disks attached via an external SATA port multiplier

I get a NULL ptr deref in ata_dev_acpi_handle with 3.6, but not with 3.5.4.
Using acpi=off convinces 3.6 to boot.

I'm new to kernel debugging and don't have a serial console, but I did
manage to slow the printk's and take a video. See around 2:00 here:
    http://www.youtube.com/watch?v=WNkQCnfc56g&t=2m1s

Please let me know if you require any further info to debug this.

Best Regards, Dan
