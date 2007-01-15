From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Proposed changes for libata speed handling
Date: Mon, 15 Jan 2007 08:52:56 -0500
Message-ID: <45AB8738.6090405@garzik.org>
References: <20070112135301.4cdba24f@localhost.localdomain>	<45A83DD2.5020000@gmail.com> <20070113100158.1d79ba9f@localhost.localdomain> <45AAF060.3040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932359AbXAONxB@vger.kernel.org>
In-Reply-To: <45AAF060.3040106@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

BTW, for a solution to be complete, we need to halt all work on all 
other ports, when issuing SET FEATURES - XFER MODE.  On SiI and Promise 
controllers, possibly others, the command is snooped and side effects 
such as register setting occur.

Long standing to-do.  Currently we hack around this by serializing the 
bus probe, and preventing people from issuing SET FEATURES - XFER MODE 
from userspace.

	Jeff
