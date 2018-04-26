From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Date: Thu, 26 Apr 2018 14:09:52 -0700
Message-ID: <20180426210952.GU1911913@devbig577.frc2.facebook.com>
References: <20180426203221.2683-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180426203221.2683-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>
List-Id: linux-ide@vger.kernel.org

On Thu, Apr 26, 2018 at 10:32:21PM +0200, Hans de Goede wrote:
> Richard Jones has reported that using med_power_with_dipm on a T450s
> with a Sandisk SD7UB3Q256G1001 SSD (firmware version X2180501) is
> causing the machine to hang.
> 
> Switching the LPM to max_performance fixes this, so it seems that
> this Sandisk SSD does not handle LPM well.
> 
> Note in the past there have been bug-reports about the following
> Sandisk models not working with min_power, so we may need to extend
> the quirk list in the future: name - firmware
> Sandisk SD6SB2M512G1022I   - X210400
> Sandisk SD6PP4M-256G-1006  - A200906
> 
> Cc: stable@vger.kernel.org
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
