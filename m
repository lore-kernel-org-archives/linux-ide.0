From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH 2/2] sata_nv: fix ATAPI issues with memory over 4GB (v3)
Date: Mon, 19 Nov 2007 23:25:48 -0600
Message-ID: <47426FDC.4030800@shaw.ca>
References: <473A7677.6080007@shaw.ca> <473BA332.9030406@gmail.com>
 <473BC5DF.1040302@shaw.ca> <474230DC.8020308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758118AbXKTF0O@vger.kernel.org>
In-reply-to: <474230DC.8020308@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Robert Hancock wrote:
>> Tejun Heo wrote:
>>> Robert Hancock wrote:
>>>> This fixes some problems with ATAPI devices on nForce4 controllers in
>>>> ADMA mode
>>>> on systems with memory located above 4GB. We need to delay setting
>>>> the 64-bit
>>>> DMA mask until the PRD table and padding buffer are allocated so that
>>>> they don't
>>>> get allocated above 4GB and break legacy mode (which is needed for ATAPI
>>>> devices).
>>>>
>>>> Signed-off-by: Robert Hancock <hancockr@shaw.ca>
>>> applied to #tj-upstream-fixes.
>>>
>> I have a report that these patches crashed but the previous patch worked:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=351451
>>
>> So there may still be a problem here.
> 
> Any progress?

It looks like the problem is that even though we set the DMA mask after 
we allocate the PRD and pad buffers, when the other port is set up, the 
DMA mask is already over 64-bit and so it allocates its buffers over 4GB 
and fails. I think we just need to explicitly set to 32-bit first, 
getting the reporter to try that one now.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
