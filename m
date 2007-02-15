From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] sata_nv: handle SError status indication
Date: Thu, 15 Feb 2007 18:09:46 -0500
Message-ID: <45D4E83A.30605@garzik.org>
References: <45CFB6A8.3010507@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161678AbXBOXJv@vger.kernel.org>
In-Reply-To: <45CFB6A8.3010507@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

Robert Hancock wrote:
> ADMA-capable controllers provide a bit in the status register that appears
> to indicate that the controller detected an SError condition. Update 
> sata_nv
> to detect this and trigger error handling in order to handle the fault.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

applied
