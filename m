From: "Dan Greve" <grevedan@hotmail.com>
Subject: RE: Secondary port on SiS 965
Date: Fri, 25 Feb 2005 11:59:52 -0500
Message-ID: <BAY102-F40C8D3EEA70029ADE9E4A9C7650@phx.gbl>
References: <1fb03f81cef68f29c170efe64abc9d93@iomega.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Received: from bay102-f40.bay102.hotmail.com ([64.4.61.50]:44685 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262749AbVBYRAQ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Feb 2005 12:00:16 -0500
In-Reply-To: <1fb03f81cef68f29c170efe64abc9d93@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: poppitzg@iomega.com, linux-ide@vger.kernel.org

I've been successful in using both ports on the 965L rev 01 controller, 
currently running a 2.6.11-rc3 patched kernel.  What version of sata_sis.c 
are you using?

I'm using the latest sata_sis.c (v 0.5) driver from SIS available at

http://download.sis.com/download_step2.php?id=155881&agree=1&country=USA

Bug reporting going on at

http://bugme.osdl.org/show_bug.cgi?id=4192

-- dan greve

>From: Gary Poppitz <poppitzg@iomega.com>
>To: linux-ide@vger.kernel.org
>Subject: Secondary port on SiS 965
>Date: Wed, 23 Feb 2005 09:03:59 -0700
>
>Has anyone also seen the problem of having a SATAPI device being detected 
>on the secondary port of the SiS 965 chipset?
>
>I am able to run correctly on the primary port but the secondary port says 
>there is no physical device present. Both ports will run our device in 
>Windows XP so this isnt a hardware problem.
>
>Any clues/solutions for this one?
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html


